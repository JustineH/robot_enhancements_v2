require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe '#heal!' do

    it 'cannot be revived if Robot already dead (has 0 health or less)' do
      @robot.wound(Robot::MAX_HEALTH)
      expect { @robot.heal!(0) }.to raise_error(Robot::RobotAlreadyDeadError)
    end

    it 'can be healed if still alive' do
      @robot.wound(Robot::MAX_HEALTH - 1)
      expect { @robot.heal!(0) }.to_not raise_error
    end
  end

end

