require 'potion'

describe Potion do
  describe '#initialize' do
    it 'should take 2 arguments: an array of rgb colors and an integer for the volume' do
      expect(Potion.allocate.method(:initialize).arity).to eq 2
    end

    it 'should raise an argument error if any of the colors is not in the rgb range (0-255)' do
      expect { Potion.new([450, 0, 0], 45) }.to raise_error(ArgumentError, 'colors should be within rgb range')
      expect { Potion.new([20, 30, -45], 10) }.to raise_error(ArgumentError, 'colors should be within rgb range')
    end

    it 'should raise an argument error if the volume is negative' do
      expect { Potion.new([20, 30, 45], -10) }.to raise_error(ArgumentError, 'volume should be positive')
    end

    it 'should raise an argument error if the volume is not an Integer' do
      expect { Potion.new([20, 30, 45], 10.0) }.to raise_error(ArgumentError, 'volume should be an Integer')
    end
  end

  describe '#colors' do
    it 'should return the potion\'s color' do
      potion = Potion.new([255, 255, 255], 40)
      result = potion.colors
      expect(result).to eq([255, 255, 255])
    end
  end


  describe '#volume' do
    it 'should return the potion\s volume' do
      potion = Potion.new([255, 255, 255], 40)
      result = potion.volume
      expect(result).to eq(40)
    end
  end

  describe '#to_s' do
    it 'should return an eye-friendly breakdown of the potion' do
      potion = Potion.new([255, 255, 255], 40)
      result = potion.to_s
      expect(result).to eq('red: 255, blue: 255, green: 255, volume: 40')
    end
  end

  describe '#mix' do
    it 'should return a new potion' do
      potion = Potion.new([153, 210, 199], 32)
      other_potion = Potion.new([135,  34,   0], 17)
      mixed_potion = potion.mix(other_potion)
      expect(mixed_potion.class).to eq Potion
    end

    it 'should correctly mix the colors and volume' do
      potions = [
        Potion.new([153, 210, 199], 32),
        Potion.new([135,  34,   0], 17),
        Potion.new([18,   19,  20], 25),
        Potion.new([174, 211,  13],  4),
        Potion.new([255,  23, 148], 19),
        Potion.new([51,  102,  51],  6)
      ]

      one_mix = potions[0].mix(potions[1])
      two_mixes = potions[0].mix(potions[2]).mix(potions[4])
      three_mixes = potions[1].mix(potions[2]).mix(potions[3]).mix(potions[5])
      four_mixes = potions[0].mix(potions[1]).mix(potions[2]).mix(potions[4]).mix(potions[5])
      five_mixes = potions[0].mix(potions[1]).mix(potions[2]).mix(potions[3]).mix(potions[4]).mix(potions[5])

      expect(one_mix.colors).to eq([147, 149, 130])
      expect(one_mix.volume).to eq(49)
      expect(two_mixes.colors).to eq([135, 101, 128])
      expect(two_mixes.volume).to eq(76)
      expect(three_mixes.colors).to eq([74, 50, 18])
      expect(three_mixes.volume).to eq(52)
      expect(four_mixes.colors).to eq([130, 91, 102])
      expect(four_mixes.volume).to eq(99)
      expect(five_mixes.colors).to eq([132, 96, 99])
      expect(five_mixes.volume).to eq(103)
    end
  end
end
