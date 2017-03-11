# coding: utf-8
require "rails_helper"

RSpec.describe Vk::FullProcessPostsService do
  let(:group) { create(:group) }
  let(:options) {
    {
      loader: MockLoaderVkWall,
      parser: Vk::ParsePostsService,
      group_id: group.id
    }
  }

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
Стартовал приём заявок в зону «Музыка» &#127908;

Если ты начинающий музыкант, у тебя есть своя группа и ты мечтаешь о славе и толпах поклонников, то присылай заявку на участие в VK Fest 2017 и, быть может, именно ты выступишь на крупнейшем open air лета! Приём заявок продлится до 1 мая.

Подать заявку можно тут: vk.cc/6aH4Yp

#vkfest2017 #music@fest
        },
          "likes" => {
            "count" => 302
          }
        }
      ]
    end
  end

  subject { ->(options) { described_class.new(options).call }}
  it {
    expect(subject.call(options)).to satisfy { |group_posts|
      group_posts.reduce(true) { |acc, is_save_successful|
        acc && is_save_successful
      }
    }
  }
end
