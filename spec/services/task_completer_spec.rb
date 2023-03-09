# frozen_string_literal: true

RSpec.describe TaskCompleter do
  describe '#call' do
    context 'when task is not completed' do
      let(:task) { create(:task) }

      it 'updates task to completed' do
        expect { described_class.call(task: task) }.to change { task.reload.status }.to('completed')
      end

      it 'updates the completed_at value' do
        expect { described_class.call(task: task) }.to change { task.reload.completed_at }.from(nil)
      end
    end

    context 'when task is completed' do
      let(:task) { create(:task, :completed) }

      it 'does not update the task' do
        expect { described_class.call(task: task) }.not_to change { task.reload.status }
      end
    end
  end
end
