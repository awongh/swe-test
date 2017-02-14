require 'swe4r'

describe "Chart Data" do

  it 'calculates julian date correctly' do

    latitude = 37.7749295

    longitude = -122.41941550000001

    Swe4r::swe_set_topo(longitude, latitude, 0)

    jd = Swe4r::swe_julday(1981, 7, 1, 1)

    expect(jd).to be_within(0.01).of(2444786.5416666665)
  end

  it 'calculates degrees the same on all systems' do

    time = 363038400

    latitude = 37.7749295

    longitude = -122.41941550000001

    Swe4r::swe_set_topo(longitude, latitude, 0)

    date = Time.at( time ).to_datetime

    hour = date.hour + ( date.min / 60 )

    puts "DATE INPUTS===== year: " + date.year.to_s + " - month: " + date.month.to_s + " - day: " + date.day.to_s + " - hour: " + hour.to_s

    jd = Swe4r::swe_julday(date.year, date.month, date.day, hour)

    body = Swe4r::swe_calc_ut(jd, 1, Swe4r::SEFLG_MOSEPH|Swe4r::SEFLG_TOPOCTR)
    longitude = body[0]

    expect(jd).to equal(2444789.625)
    expect(longitude).to equal(132.34025732269768)

  end
end
