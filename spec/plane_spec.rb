require './lib/plane'
require './lib/airport'

describe Plane do

  let(:weather) { double(:weather) }
  let(:airport) { double(:airport) }
  

  before(:each) do
    @plane = Plane.new
    allow(airport).to receive(:runway)
    allow(airport).to receive(:store)
  end

  describe "will not land" do

    it "at airport that is full" do
      allow(weather).to receive(:stormy?).and_return(false)
      allow(airport).to receive(:full?).and_return(true)
      expect { @plane.land(airport, weather) }.to raise_error("Airport full")
    end

    it "if weather is stormy" do
      allow(airport).to receive(:full?).and_return(false)
      allow(weather).to receive(:stormy?).and_return(true)
      expect { @plane.land(airport, weather) }.to raise_error("Stormy weather")
    end
  
  end

  describe "lands" do

    it "if airport is not full and weather is not stormy" do
      allow(weather).to receive(:stormy?).and_return(false)
      allow(airport).to receive(:full?).and_return(false)
      expect { @plane.land(airport, weather) }.to change { @plane.location }.to (airport)
    end

  end

  describe "if not at airport" do

    it "will not take off" do
      expect { @plane.take_off(airport, weather) }.to raise_error("Already in the air")
    end

  end

  describe "if at airport" do

    before(:each) do
      allow(airport).to receive(:full?).and_return(false)
      allow(weather).to receive(:stormy?).and_return(false)
      @plane.land(airport, weather)
    end

    describe "will not take off" do

      it "when weather is stormy" do
        allow(weather).to receive(:stormy?).and_return(true)
        expect { @plane.take_off(airport, weather) }.to raise_error("Stormy weather")
      end
    
    end

    describe "will take off" do

      it "when weather is not stormy" do
        allow(weather).to receive(:stormy?).and_return(false)
        expect { @plane.take_off(airport, weather) }.to change { @plane.location }.to (:in_air)
      end
    
    end

  end

end
