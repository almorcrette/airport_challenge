require './lib/plane'
require './lib/airport'

describe Plane do

  let(:weather) { double(:weather) }
  let(:airport) { double(:airport) }

  before(:each) do
    @plane = Plane.new
  end

  it "lands at the designated airport when instructed if airport is not full and weather is not stormy" do
    allow(weather).to receive(:stormy?).and_return(false)
    allow(airport).to receive(:full?).and_return(false)
    allow(airport).to receive(:hangar).and_return([])
    @plane.land(airport, weather)
    # expect(airport.hangar).to include(@plane)
    expect(@plane.land(airport, weather)).to eq @plane
  end

  it "will not land at airport that is full" do
    allow(weather).to receive(:stormy?).and_return(false)
    allow(airport).to receive(:full?).and_return(true)
    expect { @plane.land(airport, weather) }.to raise_error("Airport full")
  end

  it "it will not land if weather is stormy" do
    allow(airport).to receive(:full?).and_return(false)
    allow(weather).to receive(:stormy?).and_return(true)
    expect { @plane.land(airport, weather) }.to raise_error("Stormy weather")
  end

  it "takes off when instructed if at an airport when weather is not stormy" do
    allow(weather).to receive(:stormy?).and_return(false)
    allow(airport).to receive(:full?).and_return(false)
    allow(airport).to receive(:hangar).and_return([])
    @plane.land(airport, weather)

    allow(weather).to receive(:stormy?).and_return(false)
    expect(@plane.take_off(weather)).to eq @plane
    # expect(airport.hangar).not_to include(@plane)
    expect(@plane.location).to eq :in_air
  end

  it "lets air traffic controller know it can't take off if instructed to do so but not at airport" do
    expect { @plane.take_off(weather) }.to raise_error("Already in the air")
  end

  it "prevents take-off when weather is stormy" do
    allow(airport).to receive(:full?).and_return(false)
    allow(weather).to receive(:stormy?).and_return(false)
    allow(airport).to receive(:hangar).and_return([])
    @plane.land(airport, weather)
    allow(weather).to receive(:stormy?).and_return(true)
    expect { @plane.take_off(weather) }.to raise_error("Stormy weather")
  end

end
