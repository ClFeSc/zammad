# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

require 'rails_helper'

RSpec.describe BackgroundServices::Cli, ensure_threads_exited: true do
  context 'when invoking scripts/background-services.rb via CLI' do

    context 'without arguments' do
      it 'shows a help screen' do
        expect { described_class.start([]) }.to output(%r{help \[COMMAND\]}).to_stdout
      end

      it 'returns success' do
        expect(described_class.start([])).to be_truthy
      end
    end

    context 'with wrong arguments' do
      it 'raises an error' do
        expect { ensure_block_keeps_running { described_class.start(['invalid-command-name']) } }.to raise_error(RuntimeError, 'Process tried to shut down unexpectedly.')
      end
    end

    context 'when running all services' do
      it 'starts scheduler correctly' do
        expect(ensure_block_keeps_running { described_class.start ['start'] }).to be(true)
      end
    end

    context 'when trying to run multiple instances' do
      it 'fails second instance' do
        thread = Thread.new { ensure_block_keeps_running { described_class.start ['start'] } }
        sleep 0.1
        expect { ensure_block_keeps_running { described_class.start ['start'] } }.to raise_error('Cannot start BackgroundServices, another process seems to be running.')
        thread.join
      end
    end

  end
end
