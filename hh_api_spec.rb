module HeadHunter
  require './head_hunter_api.rb'

  RSpec.describe 'Head Hunter API', type: :request do
    before do
      @head_hunter_api = HeadHunterAPI.new
      @success_code = 200
      @area_num = 9
      @vacancy = 'QA Automation Engineer'
      @employer = { id: 213397, name: 'МойОфис' }
      @area = { id: 2, name: 'Санкт-Петербург' }
      @area_nums = { 'Россия' => 84,
                     'Украина' => 25,
                     'Казахстан' => 156,
                     'Азербайджан' => 53,
                     'Беларусь' => 12,
                     'Грузия' => 26,
                     'Другие регионы' => 153,
                     'Кыргызстан' => 25,
                     'Узбекистан' => 116}
    end

    context "/areas endpoint" do
      it "/areas should return required areas number" do
        body, code = @head_hunter_api.areas
        expect(body.size).to eq(@area_num)
        expect(code).to eq(@success_code)
      end

      it '/areas should return required sub-areas number' do
        body, code = @head_hunter_api.areas
        body.each { |area| expect(area['areas'].size).to eq(@area_nums[area['name']]) }
        expect(code).to      eq(@success_code)
      end

      it '/areas should return required attributes' do
        body, code = @head_hunter_api.areas
        area = body.sample
        expect(area).to have_key('id')
        expect(area).to have_key('name')
        expect(area).to have_key('parent_id')
        expect(area).to have_key('areas')
        expect(code).to eq(@success_code)
      end

      it '/areas should return required sub-area attributes' do
        body, code = @head_hunter_api.areas
        area = body.sample
        sub_area = area['areas'].sample
        expect(sub_area).to have_key('id')
        expect(sub_area).to have_key('name')
        expect(sub_area).to have_key('parent_id')
        expect(sub_area).to have_key('areas')
        expect(code).to     eq(@success_code)
      end
    end

    context "/employers endpoint" do
      it '/employers?text=<> should be responded' do
        body, code = @head_hunter_api.employers('МойОфис')
        expect(body["found"].to_i).to be > 0
        expect(code).to               eq(@success_code)
      end

      it '/employers should return required attributes' do
        body, code = @head_hunter_api.employers('')
        expect(body).to be_a(Hash)
        expect(body).to have_key('items')
        expect(body).to have_key('found')
        expect(body).to have_key('pages')
        expect(body).to have_key('per_page')
        expect(body).to have_key('page')
        expect(code).to eq(@success_code)
      end
    end

    context '/vacancies endpoint' do
      it '/vacancies?text=QA Automation Engineer&area=Санкт-Петербург&emploer_id=МойОфис should be responded' do
        body, code = @head_hunter_api.vacancies(@vacancy, @area[:id], @employer[:id])
        vacancy = body['items'].sample
        expect(body['found'].to_i).to be > 0
        expect(vacancy['name']).to include(@vacancy)
        expect(code).to               eq(@success_code)
      end

      it '/vacancies should return required attributes' do
        body, code = @head_hunter_api.vacancies(@vacancy, @area[:id], @employer[:id])
        expect(body["found"].to_i).to    be > 0
        expect(body).to have_key('items')
        expect(body).to have_key('found')
        expect(body).to have_key('pages')
        expect(body).to have_key('page')
        expect(body).to have_key('clusters')
        expect(body).to have_key('arguments')
        expect(body).to have_key('alternate_url')
        expect(code).to eq(@success_code)
      end
    end
  end
end
