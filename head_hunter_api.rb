module HeadHunter
  require 'httparty'
  require 'json'

  class HeadHunterAPI
    BASE_URI = 'https://api.hh.ru'
    AREAS_URI = 'areas'
    VACANCIES_URI = 'vacancies'
    EMPLOYERS_URI = 'employers?'
    HEADERS = { "Accept" => "application/json" }

    def areas
      response = HTTParty.get("#{BASE_URI}/#{AREAS_URI}")
      [JSON.parse(response.body), response.code]
    end

    def employers(text)
      query = { text: text }
      response =HTTParty.get("#{BASE_URI}/#{EMPLOYERS_URI}", query: query)
      [JSON.parse(response.body), response.code]
    end

    def vacancies(text, area=nil, employer_id=nil)
      query = { text: text, area: area, employer_id: employer_id}
      query.reject { |_, value| value.nil? }
      response = HTTParty.get("#{BASE_URI}/#{VACANCIES_URI}", query: query)
      [JSON.parse(response.body), response.code]
    end
  end
end