require 'spec_helper'

describe RandomWatch do

  describe '.tick' do
    let(:watch) { RandomWatch.create }

    it 'creates a datapoint' do
      expect {
        watch.tick
      }.to change { Datapoint.count }.by(1)
    end

    context 'when there are no previous datapoints' do
      it 'created datapoint value is 42' do
        watch.tick
        expect(Datapoint.last.value).to eq 42
      end
    end

    context 'when there are previous datapoints' do
      before(:each) { 300.times { watch.tick } }

      it 'created datapoint value is within 20% of last value' do
        datapoints = Datapoint.all
        datapoints.count.times do |index|
          first_value = datapoints[index].value
          max = first_value + RandomWatch::MAX_MOD*first_value
          min = first_value - RandomWatch::MAX_MOD*first_value

          second_point = datapoints[index+1]
          expect((min..max)).to include second_point.value unless second_point.nil?
        end
      end
    end
  end

end
