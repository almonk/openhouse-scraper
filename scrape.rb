require 'mechanize'
require 'csv'


mechanize = Mechanize.new

start_page = 1

CSV.open("openhouse.csv", "w") do |csv|

  while start_page < 76 do
    page = mechanize.get('http://events.londonopenhouse.org/Venues?Page=' + start_page.to_s)

    page.search('.listing-detail').each do |item|
      puts item.search('h2 a').text.strip
      csv << [item.search('h2 a').text.strip, item.search('address').text.strip, item.search('h2 a').attribute('href').text.strip]
    end

    start_page = start_page + 1
  end
end
