require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper_remote_ok
    url = 'https://remoteok.com/remote-ruby-jobs'
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    jobs = Array.new


    job_listings = parsed_page.css('tr.job')

    job_listings.each do |job_listing|
        job = {
        company: job_listing.css('h3').text.strip,
        title: job_listing.css('h2').text.strip,
        link: 'https://remoteok.com' + job_listing.css('a').first['href']
        }

        unless job[:title].include? "Senior"
            jobs << job
        end
    end

    jobs.each do |j|
        puts j[:title]
    end
end

scraper_remote_ok

