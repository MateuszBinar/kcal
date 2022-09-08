require "rails_helper"

RSpec.describe EntriesController do
  include Warden::Test::Helpers
  include Devise::Test::ControllerHelpers
  let!(:user){ create(:user) }
  let!(:user2){ create(:user) }
  let!(:entry1){ create(:entry, created_at: DateTime.now - 1.hour, user_id: user.id) }
  let!(:entry2){ create(:entry, created_at: DateTime.now - 2.days, user_id: user.id) }
  let!(:photo){ create(:photo) }
  let!(:entry_params){ { meal_type: 'jedzonko', calories: 300, proteins: 20, carbohydrates: 30, fats: 32, photo: { title: '', image: '' } } }


  describe 'GET #index' do
    subject { get :index }

    context 'user not logged in' do
      it 'should not show list of today entries' do
        subject
        expect(assigns(:entries)).not_to contain_exactly(entry1)
      end

      it 'should redirect to log in page' do
        expect(subject).to redirect_to(new_user_session_path)
      end
    end

    context 'user logged in' do
      before { sign_in(user) }

      it "renders the index template" do
        expect(subject).to render_template(:index)
      end

      it 'should show list of today entries' do
        subject
        expect(assigns(:entries)).to contain_exactly(entry1)
      end
    end
  end

  describe 'POST #create' do
    subject { post(:create, params: entry_params) }

    context 'user not logged in' do
      it 'should redirect to log in page' do
        expect(subject).to redirect_to(new_user_session_path)
      end

      it 'should not create entry object' do
        expect { subject }.to change(Entry, :count).by(0)
      end
    end

    context 'user logged in' do
      before { sign_in(user) }

      it 'should create entry and photo object' do
        expect { subject }.to change(Entry, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: entry1.id } }

    context 'no user logged in' do
      it 'should not delete entry object' do
        expect { subject }.to change(Entry, :count).by(0)
      end

      it 'should redirect to log in page' do
        expect(subject).to redirect_to(new_user_session_path)
      end
    end

    context 'other user logged in' do
      before { sign_in(user2) }
      it 'should not delete entry object' do
        expect { subject }.to change(Entry, :count).by(0)
      end
    end

    context 'user logged in' do
      before { sign_in(user) }
      it 'should delete entry object' do
        expect { subject }.to change(Entry, :count).by(-1)
      end
    end
  end
end
