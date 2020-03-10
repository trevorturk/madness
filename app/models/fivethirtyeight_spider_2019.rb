class FivethirtyeightSpider2019 < Kimurai::Base
  @name = "fivethirtyeight_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://projects.fivethirtyeight.com/2019-march-madness-predictions/"]

  def parse(response, url:, data: {})
    browser.select "March 21 (1st round)", from: "forecast-selector-mens"

    browser.current_response.css("table#team-table tbody tr").each do |tr|
      next if tr.attributes["class"].value.match(/dead/)

      name = Normalizer.team_name(tr.css("td")[1].text.match(/\D+/).to_s.squish)

      tr.css("td").each.with_index do |td, index|
        next unless index >= 5
        item = {}
        item[:name] = name
        item[:round] = index - 4
        item[:percentage] = Normalizer.percentage(td.text)

        save_to "public/spiders/fivethirtyeight_spider_2019.json", item, position: false, format: :json
        save_to "public/spiders/fivethirtyeight_spider_2019.csv", item, position: false, format: :csv
      end
    end
  end
end

# FivethirtyeightSpider2019.crawl!
