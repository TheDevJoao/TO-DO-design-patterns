# frozen_string_literal: true

RSpec.describe TaskCompleter do
  describe '.call' do
    context 'when task is not completed' do
      let(:task) { create(:task) }

      it 'updates task to completed' do
        expect { described_class.call(task:) }.to change { task.reload.status }.to('completed')
      end

      it 'updates the completed_at value' do
        expect { described_class.call(task:) }.to change { task.reload.completed_at }.from(nil)
      end
    end

    context 'when task is completed' do
      let(:task) { create(:task, status: :completed) }

      it 'does not update the task' do
        expect { described_class.call(task:) }.not_to change{task.reload.status}
      end
    end

    context "when the user has notification preference: 'email'" do
      let(:user) { build(:user, notification_preferences: { 'task_completed' => ['email'] }) }
      let(:task) { build(:task, user:) }

      it 'returns a user with an email notification preference' do
        expect(task.user.notification_preferences['task_completed']).to include('email')
      end
    end

    context "when the user has notification preference: 'sms'" do
      let(:user) { build(:user, notification_preferences: { 'task_completed' => ['sms'] }) }
      let(:task) { build(:task, user:) }

      it 'returns a user with a sms notification preference' do
        expect(task.user.notification_preferences['task_completed']).to include('sms')
      end
    end

    context "when the user has notification preference: 'telegram'" do
      let(:user) { build(:user, notification_preferences: { 'task_completed' => ['telegram'] }) }
      let(:task) { build(:task, user:) }

      it 'returns a user with a telegram notification preference' do
        expect(task.user.notification_preferences['task_completed']).to include('telegram')
      end
    end

    context "when the user has notification preference: 'whatsapp'" do
      let(:user) { build(:user, notification_preferences: { 'task_completed' => ['whatsapp'] }) }
      let(:task) { build(:task, user:) }

      it 'returns a user with a whatsapp notification preference' do
        expect(task.user.notification_preferences['task_completed']).to include('whatsapp')
      end
    end
  end
end
