require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'GET #index' do
    it "@itemsに正しい値が入る" do
      Items = create_list(:item, 4, :image, user: user, category: category)
      items = Item.where.not(boughtflg_id: '2').includes(:user).last(3)
      get :index
      expect(assigns(:items)).to eq(items)
    end
    it "トップページに遷移する" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "詳細ページを表示する" do 
      items = create_list(:item, 4, :image, user: user, category: category)
      item = Item.find(items[1][:id])
      get :show, params: { id: item.id }
      expect(response).to render_template :show
    end 
  end

  describe 'GET #new' do
    context 'ログインしている' do
      it "@itemという変数が正しく定義されている" do
        login user
        get :new
        expect(assigns(:item)).to be_a_new(Item)
      end
      it "@category_parentに正しい値が入る" do
        othercategory = create(:category, name: 'other', ancestry: nil)
        @category_parent =  Category.where("ancestry is null")
        login user
        get :new
        expect(@category_parent).to eq([othercategory])
      end
      it '出品ページが表示される' do
        login user
        get :new
        expect(response).to render_template :new
      end
    end
    context 'ログインしていない' do
      it 'ログインページに遷移する' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe 'POST #create' do
    let(:image) { fixture_file_upload('spec/images/Unknown.jpeg','image/jpeg' )}
    let(:item_image) { { item: attributes_for(:item, user_id: user.id, category_id: category.id ,images: [image])}}
    let(:item) { { item: attributes_for(:item, user_id: user.id, category_id: category.id )}}
    context 'ログインしている' do
      subject { post :create, params: item_image}
      context '保存できる' do
        it 'レコードの数が増える' do
          login user
          expect{subject}.to change(Item, :count).by(1)
        end
        it 'トップページにリダイレクトする' do
          login user
          subject
          expect(response).to redirect_to(root_path)
        end
      end
      context '保存できない' do
        subject { post :create, params: item}
        it 'レコードの数が変わらない' do
          login user
          expect{subject}.to_not change(Item, :count)
        end
        it '出品画面に戻る' do
          login user
          subject
          expect(response).to render_template :new
        end
      end
    end
    context 'ログインしていない' do
      it 'ログインページに遷移する' do
        post :create, params: item
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    let(:item) { create(:item, :image, user: user, category: category) }
    context "ログインしている" do
      it "@category_grandchildrenに正しい値が入る" do
        login user
        get :edit, params: { id: item.id }
        expect(item.category_id).to eq(category.id)
      end
      it "@category_parentに正しい値が入る" do
        othercategory = create(:category, name: 'other', ancestry: nil)
        @category_parent =  Category.where("ancestry is null")
        login user
        get :edit, params: { id: item.id }
        expect(@category_parent).to eq([othercategory])
      end
      it "出品者、編集画面に遷移する" do
        login user
        get :edit, params: { id: item.id }
        expect(response).to render_template :edit
      end
      it "出品者ではない、トップページにリダイレクトする" do
        otheruser = create(:user)
        login otheruser
        get :edit, params: { id: item.id }
        expect(response).to redirect_to(root_path)
      end
    end
    context 'ログインしていない' do
      it 'ログインページに遷移する' do
        get :edit, params: { id: item.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  
  describe 'PATCH #update' do
    let(:image) { fixture_file_upload('spec/images/Unknown.jpeg','image/jpeg' )}
    let(:item_image) { { item: attributes_for(:item, user_id: user.id, category_id: category.id ,images: [image])}}
    let(:item) { create(:item, :image, user: user, category: category) }
    context 'ログインしている' do
      let(:unsaved_item) { { item: attributes_for(:item, user_id: user.id, id: item.id + 1 , category_id: category.id ,images: [image])}}
      before do
        login user
      end
      context 'アイテムが既に保存されている' do
        context '編集成功' do
          it '編集出来た' do
            update_item = attributes_for(:item, name: 'edit', user_id: user.id, category_id: category.id ,images: [image])
            patch :update, params: {id: item.id, item: update_item}
            item.reload
            expect(item.name).to eq("edit")
          end
          it 'トップページにリダイレクトする' do
            update_item = attributes_for(:item, name: 'edit', user_id: user.id, category_id: category.id ,images: [image])
            patch :update,  params: {id: item.id, item: update_item}
            expect(response).to redirect_to(root_path)
          end
        end
        context '編集失敗' do
          it '編集出来ない' do
            patch :update, params: {id: item.id, item: unsaved_item}
            item.reload
            expect(response).to have_http_status "302"
          end
          it 'トップページにリダイレクトする' do
            patch :update,  params: {id: item.id, item: unsaved_item}
            expect(response).to redirect_to(root_path)
          end
        end
      end
      context 'アイテムが保存されていない' do
        it '更新するアイテムがない' do
          patch :update,  params: {id: item.id, item: unsaved_item}
          expect(response).to have_http_status "302"
        end
        it 'トップページにリダイレクトする' do
          patch :update,  params: {id: item.id, item: unsaved_item}
          expect(response).to redirect_to(root_path)
        end
      end
    end
    context 'ログインしていない' do
      it 'ログインページに遷移する' do
        update_item = attributes_for(:item, user_id: user.id, category_id: category.id ,images: [image])
        patch :update,  params: {id: item.id, item: update_item}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'delete #destroy' do
    let!(:item) { create(:item, :image, user: user, category: category) }
    context "ログインしている" do
      context "削除しようとしたitemがある時" do
        context "削除成功" do
          it '削除できた' do
            login user
            expect{delete :destroy, params: {id: item.id}}.to change(Item, :count).by(-1)
          end
          it "トップページにリダイレクトする" do
            login user
            delete :destroy, params: {id: item.id}
            expect(response).to redirect_to(root_path)
          end
        end
        context "削除失敗" do
          it '削除出来ない' do
            login user
            expect{delete :destroy, params: {id: item.id + 1}}.to change(Item, :count).by(0)
            expect(response).to have_http_status "302"
          end
          it "トップページにリダイレクトする" do
            login user
            delete :destroy, params: {id: item.id}
            expect(response).to redirect_to(root_path)
          end
        end
      end
      context "削除しようとしたitemがない時" do
        it '削除出来ない' do
          login user
          expect{delete :destroy, params: {id: item.id + 1}}.to change(Item, :count).by(0)
        end
        it "トップページにリダイレクトする" do
          login user
          delete :destroy, params: {id: item.id + 1}
          expect(response).to redirect_to(root_path)
        end
      end
    end
    context 'ログインしていない' do
      it 'ログインページに遷移する' do
        delete :destroy, params: {id: item.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end