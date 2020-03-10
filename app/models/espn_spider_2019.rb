class EspnSpider2019 < Kimurai::Base
  @name = "espn_spider"
  @engine = :mechanize
  @start_urls = ["http://fantasy.espn.com/tournament-challenge-bracket/2019/en/whopickedwhom"]

  def parse(response, url:, data: {})
    response.css("table tbody tr").each do |tr|
      tr.css("td").each.with_index do |td, index|
        item = {}

        item[:name] = Normalizer.team_name(td.css(".teamName").text)
        item[:round] = index + 1
        item[:percentage] = Normalizer.percentage(td.css(".percentage").text)

        save_to "public/spiders/espn_spider_2019.json", item, position: false, format: :json
        save_to "public/spiders/espn_spider_2019.csv", item, position: false, format: :csv
      end
    end
  end
end

# EspnSpider2019.crawl!
