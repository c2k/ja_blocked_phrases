class JaBlockedPhrasesController < ApplicationController
  # GET /ja_blocked_phrases
  # GET /ja_blocked_phrases.json
  def index
    @ja_blocked_phrases = JaBlockedPhrase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ja_blocked_phrases }
    end
  end

  # GET /ja_blocked_phrases/1
  # GET /ja_blocked_phrases/1.json
  def show
    @ja_blocked_phrase = JaBlockedPhrase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ja_blocked_phrase }
    end
  end

  # GET /ja_blocked_phrases/new
  # GET /ja_blocked_phrases/new.json
  def new
    @ja_blocked_phrase = JaBlockedPhrase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ja_blocked_phrase }
    end
  end

  # GET /ja_blocked_phrases/1/edit
  def edit
    @ja_blocked_phrase = JaBlockedPhrase.find(params[:id])
  end

  # POST /ja_blocked_phrases
  # POST /ja_blocked_phrases.json
  def create
    @ja_blocked_phrase = JaBlockedPhrase.new(params[:ja_blocked_phrase])

    respond_to do |format|
      if @ja_blocked_phrase.save
        format.html { redirect_to @ja_blocked_phrase, notice: 'Ja blocked phrase was successfully created.' }
        format.json { render json: @ja_blocked_phrase, status: :created, location: @ja_blocked_phrase }
      else
        format.html { render action: "new" }
        format.json { render json: @ja_blocked_phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ja_blocked_phrases/1
  # PUT /ja_blocked_phrases/1.json
  def update
    @ja_blocked_phrase = JaBlockedPhrase.find(params[:id])

    respond_to do |format|
      if @ja_blocked_phrase.update_attributes(params[:ja_blocked_phrase])
        format.html { redirect_to @ja_blocked_phrase, notice: 'Ja blocked phrase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ja_blocked_phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ja_blocked_phrases/1
  # DELETE /ja_blocked_phrases/1.json
  def destroy
    @ja_blocked_phrase = JaBlockedPhrase.find(params[:id])
    @ja_blocked_phrase.destroy

    respond_to do |format|
      format.html { redirect_to ja_blocked_phrases_url }
      format.json { head :no_content }
    end
  end
end
