require 'date'

def script_output
  `ruby ./last_sunday.rb #{birthdate}`
end

RSpec.describe 'Last Sunday' do
  before do
    allow(Date).to receive(:today).and_return Date.new(2024, 1, 3)
  end

  let(:birthdate) { '1985-06-08' }

  it 'calculates remaining Sundays correctly' do
    expect(script_output).to include('2148')
  end

  it 'shows birth year' do
    expect(script_output).to include('1985')
  end

  it 'shows the last year' do
    expect(script_output).to include('2064')
  end

  describe 'handles incorrect number of args' do
    it do
      script_output = `ruby ./last_sunday.rb`
      expect(script_output).to include('Usage: ')
    end
  end

  describe 'handles invalid date format' do
    let(:birthdate) { '1985' }

    it do
      expect(script_output).to include('Invalid date format')
    end
  end
end
