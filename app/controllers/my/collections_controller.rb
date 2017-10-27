module My
  class CollectionsController < BaseController

    def index
      @user = current_user
      @collections = current_user.collections.page(params[:page])
    end

    def create
      product = Product.find(params[:product_id])
      if product
        collection = Collection.new
        collection.user = current_user
        collection.product = product
        if collection.save
          product.collection_count+=1
          product.save
          render js: "alert('收藏成功！');$('#collection').html('已收藏(收藏次数：#{product.collection_count})');"
        else
          render js: "alert('收藏失败！');"
        end
      else
        render js: "alert('收藏失败！');"
      end
    end

    def destroy
      @collection = Collection.find(params[:id])
      product = @collection.product
      @collection.destroy
      #maybe not destroy
      #product.collection_count-=1
      #product.save
      respond_to do |format|
        format.html { redirect_to  my_collections_path, notice: '信息删除成功' }
        format.json { head :no_content }
      end
    end


  end

end
