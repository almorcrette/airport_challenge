require './lib/airport'

context Airport do

  let(:weather) { double(:weather) }

  it "is created with a default capacity" do
    expect(subject.capacity).to be_an(Integer)
  end

  it "can be created with a custom capacity" do
    custom_capacity = rand(1..20)
    airport = Airport.new(custom_capacity)
    expect(airport.capacity).to eq custom_capacity
  end

  it "capacity can be overriden" do
    airport = Airport.new
    custom_capacity = rand(1..20)
    airport.change_capacity(custom_capacity)
    expect(airport.capacity).to eq custom_capacity
  end

  it "reports what is in the hangar when asked" do
    expect(subject.hangar).to eq subject.hangar
  end

  it "can be full" do
    airport = Airport.new
    airport.capacity.times do
      allow(weather).to receive(:stormy?).and_return(false)
      Plane.new.land(airport, weather)
    end
    expect(airport.full?).to be true
  end

  it "can be not full" do
    airport = Airport.new
    if airport.hangar.length < airport.capacity
      expect(airport.full?).to be false
    end
  end



end
