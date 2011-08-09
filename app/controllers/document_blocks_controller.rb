class DocumentBlocksController < ApplicationController
  

  # GET /document_blocks/1
  # GET /document_blocks/1.json
  def show
    @document_block = DocumentBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document_block }
    end
  end

  # GET /document_blocks/new
  # GET /document_blocks/new.json
  def new
    @document_block = DocumentBlock.new

    respond_to do |format|
      format.html {redirect_to edit_portfolio_project_path(params[:project_id])+"?new_document_block=1"}
      format.json { render json: @document_block }
    end
  end

  # GET /document_blocks/1/edit
  def edit
    @document_block = DocumentBlock.find(params[:id])
    redirect_to get_redirect_path
  end

  # POST /document_blocks
  # POST /document_blocks.json
  def create
    @document_block = DocumentBlock.new(params[:document_block])

    respond_to do |format|
      if @document_block.save
        format.html { redirect_to get_redirect_path, notice: 'Document block was successfully created.' }
        format.json { render json: @document_block, status: :created, location: @document_block }
      else
        flash[:error] = "Document block cannot be created due to validation errors"
        format.html { redirect_to edit_portfolio_project_path(@document_block.project_id)+"?new_document_block=1" }
        format.json { render json: @document_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /document_blocks/1
  # PUT /document_blocks/1.json
  def update
    @document_block = DocumentBlock.find(params[:id])

    respond_to do |format|
      if @document_block.update_attributes(params[:document_block])
        format.html {  redirect_to get_redirect_path, notice: 'Document block was successfully updated.' }
        format.json { head :ok }
      else
        flash[:error] = "Document block cannot be saved due to validation errors"
        format.html { redirect_to get_redirect_path  }
        format.json { render json: @document_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_blocks/1
  # DELETE /document_blocks/1.json
  def destroy
    @document_block = DocumentBlock.find(params[:id])
    @document_block.destroy

    respond_to do |format|
      flash[:notice] = "Document block <em>#{@document_block.title}</em> has been deleted.".html_safe
      format.html {redirect_to edit_portfolio_project_path(@document_block.project_id)+"?new_document_block=1"}
      format.json { head :ok }
    end
  end
  
  private
    
    def get_redirect_path
      edit_portfolio_project_path(@document_block.project)+"?document_block_id=#{@document_block.id}"
    end
end
