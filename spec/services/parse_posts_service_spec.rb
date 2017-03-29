# coding: utf-8
require "rails_helper"

RSpec.describe Vk::ParsePostsService do
  let(:example_posts) {
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
        },
        "reposts" => {
          "count" => 3
        },
        "views" => {
          "count" => 5
        },
        "comments" => {
          "count" => 6
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
        },
        "reposts" => {
          "count" => 4
        },
        "views" => {
          "count" => 7
        },
        "comments" => {
          "count" => 4
        }
      }
    ]
  }
  let(:options) {
    {
      posts_list: example_posts,
      group_id: @group.id
    }
  }

  before do
    @group = create(:group)
  end
  subject { ->() { described_class.new(options).call } }
  it {
    expect(subject.call()).to satisfy { |posts|
      posts.all? { |p| !p.id.nil? }
    }
  }
  # it "must attach themes" do
  #   subject.call()
  #   posts = GroupPost.all
  #   expect(posts).to satisfy { |psts| psts.all? { |p| !p.theme.nil? } }
  #   expect(posts.first.theme).to eq(Theme.find_by(group: @group, hashtag: "vkfest2016"))
  #   expect(posts.last.theme).to eq(Theme.find_by(group: @group, hashtag: "vkfest2017"))
  # end
end
