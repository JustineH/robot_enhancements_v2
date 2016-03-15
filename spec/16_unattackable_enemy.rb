require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
    @enemy = Robot.new
  end

  describe '#attack!' do

    it 'should not attack anything other than a Robot' do
      expect { @robot.attack!(nil)}.to raise_error(Robot::UnattackableEnemy)
    end

    it 'should attack an enemy' do
      expect { @enemy.attack!(@enemy)}.to_not raise_error
    end
  end

end

