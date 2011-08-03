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


  # GET /text_blocks/1/edit
  def edit
    @text_block = TextBlock.find(params[:id])
  end

  # POST /text_blocks
  # POST /text_blocks.json
  def create
    
    @text_block = TextBlock.new(params[:text_block])

    respond_to do |format|
      if @text_block.save
        format.html { redirect_to edit_portfolio_project_path(@text_block.project), notice: 'Writing was added successfully.' }
        format.json { render json: @text_block, status: :created, location: @text_block }
      else
        format.html { render action: "new" }
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
        format.html { redirect_to edit_portfolio_project_path(@text_block.project), notice: 'Text block was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
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
      format.html { redirect_to edit_portfolio_project_path(@text_block.project) }
      format.json { head :ok }
    end
  end
end