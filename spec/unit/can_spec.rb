# encoding: utf-8

require 'spec_helper'

describe FiniteMachine, 'can?' do

  it "allows to check if event can be fired" do
    fsm = FiniteMachine.define do
      initial :green

      events {
        event :slow,  :green  => :yellow
        event :stop,  :yellow => :red
        event :ready, :red    => :yellow
        event :go,    :yellow => :green
      }
    end

    expect(fsm.current).to eql(:green)

    expect(fsm.can?(:slow)).to be_true
    expect(fsm.can?(:stop)).to be_false
    expect(fsm.can?(:ready)).to be_false
    expect(fsm.can?(:go)).to be_false

    fsm.slow
    expect(fsm.current).to eql(:yellow)

    expect(fsm.can?(:slow)).to be_false
    expect(fsm.can?(:stop)).to be_true
    expect(fsm.can?(:ready)).to be_false
    expect(fsm.can?(:go)).to be_true

    fsm.stop
    expect(fsm.current).to eql(:red)

    expect(fsm.can?(:slow)).to be_false
    expect(fsm.can?(:stop)).to be_false
    expect(fsm.can?(:ready)).to be_true
    expect(fsm.can?(:go)).to be_false

    fsm.ready
    expect(fsm.current).to eql(:yellow)

    expect(fsm.can?(:slow)).to be_false
    expect(fsm.can?(:stop)).to be_true
    expect(fsm.can?(:ready)).to be_false
    expect(fsm.can?(:go)).to be_true
  end
end
