# coding: utf-8
require "rails_helper"

RSpec.describe Vk::FullProcessPostsService do
  class MockLoaderVkWall
    def initialize(options = {})
    end

    def call
      [
        {
          "id" => 1,
          "date" => 1465844495,
          "text" => %{
        Лекции и мастер-классы по боевым искусствам и самозащите на VK Fest

Сообщество [club60755336|«Боевые ботаники»] подготовило специальный цикл лекций о самообороне и единоборствах, последствиях применения оружия в рамках самозащиты, принципах поведения в конфликтных ситуациях, о том, можно ли совмещать «качалку» и единоборства.
А после теоретического курса гости фестиваля смогут познакомиться с различными видами боевых искусств, попробовать себя в них, получить начальные навыки самозащиты и поведения в критических ситуациях под руководством мастеров и тренеров разных видов единоборств.

Билеты: vk.cc/tickets

#vkfest2016 #sport@fest
        },
          "likes" => {
            "count" => 103
          }
        },
        {
          "id" => 2,
          "date" => 1488400253,
          "text" => %{
Стартовал приём заявок в зону «Музыка»

Если ты начинающий музыкант, у тебя есть своя группа и ты мечтаешь о славе и толпах поклонников, то присылай заявку на участие в VK Fest 2017 и, быть может, именно ты выступишь на крупнейшем open air лета! Приём заявок продлится до 1 мая.

Подать заявку можно тут: vk.cc/6aH4Yp

#vkfest2017 #music@fest
        },
          "likes" => {
            "count" => 302
          }
        },
        {
          "id" => 3,
          "date" => 1488400253,
          "text" => %{
Стартовал приём заявок в зону «Музыка»

Если ты начинающий музыкант, у тебя есть своя группа и ты мечтаешь о славе и толпах поклонников, то присылай заявку на участие в VK Fest 2017 и, быть может, именно ты выступишь на крупнейшем open air лета! Приём заявок продлится до 1 мая.

Подать заявку можно тут: vk.cc/6aH4Yp

#vkfest2018 #music@fest
        },
          "likes" => {
            "count" => 302
          }
        }
      ]
    end
  end

  context "without analyzer" do
    let(:group) { create(:group) }
    let(:options) {
      {
        loader: MockLoaderVkWall,
        parser: Vk::ParsePostsService,
        group_id: group.id
      }
    }

    subject { ->(options) { described_class.new(options).call }}
    it {
      expect(subject.call(options)).to satisfy { |group_posts|
        group_posts.reduce(true) { |acc, post|
          acc && !post.id.nil?
        }
      }
    }
  end

  context "with analyzer" do

    context "no_create option" do
      before {
        @group = create(:group)
        create(:theme, hashtag: "vkfest2016", group_id: @group.id, name: "vkfest2016")
        create(:theme, hashtag: "vkfest2017", group_id: @group.id, name: "vkfest2017")
      }
      let(:options) {
        {
          loader: MockLoaderVkWall,
          parser: Vk::ParsePostsService,
          analyzer: Vk::PostsAnalyzerService,
          undefined_theme_fallback: :no_create, # optional
          group_id: @group.id
        }
      }

      subject { ->(options) { described_class.new(options).call }}
      it {
        expect(subject.call(options)).to satisfy { |group_posts|
          # check that first two posts have themes and the last one dont
          head_part_successful = group_posts.take(2).reduce(true) { |acc, post|
            acc && !post.id.nil? && !post.theme.nil?
          }
          msg_without_theme = group_posts.last
          tail_part_successful = msg_without_theme.theme.nil? && Theme.find_by(id: msg_without_theme.theme_id).nil?
          head_part_successful && tail_part_successful
        }
      }
    end

    context "create_new option" do
      before {
        @group = create(:group)
        create(:theme, hashtag: "vkfest2016", group_id: @group.id, name: "vkfest2016")
        create(:theme, hashtag: "vkfest2017", group_id: @group.id, name: "vkfest2017")
      }
      let(:options) {
        {
          loader: MockLoaderVkWall,
          parser: Vk::ParsePostsService,
          analyzer: Vk::PostsAnalyzerService,
          undefined_theme_fallback: :create_new,
          group_id: @group.id
        }
      }

      subject { ->(options) { described_class.new(options).call }}
      it {
        expect(subject.call(options)).to satisfy { |group_posts|
          # check that first two posts have themes (they are predefined) and last one should be created dynamic
          head_part_successful = group_posts.take(2).reduce(true) { |acc, post|
            acc && !post.id.nil? && !post.theme.nil?
          }

          msg_without_theme = group_posts.last
          theme = Theme.find_by(id: msg_without_theme.theme_id)

          tail_part_successful = !msg_without_theme.theme.nil? &&
                                 !theme.nil? &&
                                 (theme.name == theme.hashtag)

          head_part_successful && tail_part_successful
        }
      }
    end
  end
end
