class TextBlocksController < ApplicationController

  # GET /text_blocks/1
  # GET /text_blocks/1.json
  def show
    @text_block = TextBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text_block }
    end
  end
  
  def new
    @text_block = TextBlock.new
    
    respond_to do |format|
      format.html{ redirect_to edit_portfolio_project_path(params[:project_id])+"?new_text_block=1" }
      format.json { render json: @text_block }
    end
  end
  
  
 

  # GET /text_blocks/1/edit
  def edit
    @text_block = TextBlock.find(params[:id])
    redirect_to get_redirect_path
  end

  # POST /text_blocks
  # POST /text_blocks.json
  def create
    @text_block = TextBlock.new(params[:text_block])
    respond_to do |format|
      if @text_block.save
        format.html { redirect_to get_redirect_path, notice: 'Writing was added successfully.' }
        format.json { render json: @text_block, status: :created, location: @text_block }
      else
        flash[:error] = "Writing cannot be created due to validation errors"
        format.html { redirect_to edit_portfolio_project_path(@text_block.project_id)+"?new_text_block=1" }
        format.json { render json: @text_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /text_blocks/1
  # PUT /text_blocks/1.json
  def update
    @text_block = TextBlock.find(params[:id])

    respond_to do |format|
      if @text_block.update_attributes(params[:text_block])
        format.html { redirect_to get_redirect_path, notice: 'Text block was successfully updated.' }
        format.json { head :ok }
      else
        flash[:error] = "Writing cannot be updated due to validation errors"
        format.html { redirect_to get_redirect_path  }
        format.json { render json: @text_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_blocks/1
  # DELETE /text_blocks/1.json
  def destroy
    @text_block = TextBlock.find(params[:id])
    @text_block.destroy

    respond_to do |format|
      format.html{ redirect_to edit_portfolio_project_path(@text_block.project_id)+"?new_text_block=1" }
      format.json { head :ok }
    end
  end
  
  private
    def get_redirect_path
      edit_portfolio_project_path(@text_block.project)+"?text_block_id=#{@text_block.id}"
    end
end
