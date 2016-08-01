class BinPackingController < ApplicationController
  def index
    @bin_width = 260
    @bin_height = 183
  end

  def pack
    @bin_width = params[:bin_width].to_f
    @bin_height = params[:bin_height].to_f
    @measures = params[:measures]
    @rotate = params.has_key?(:rotate)

    @bins = BinPack.pack(
      {
        width: @bin_width,
        height: @bin_height
      },
      @measures.gsub("\r", '').split("\n").map do |measure|
        measure = measure.split(',')
        { width: measure[0].to_f, height: measure[1].to_f }
      end, @rotate
    )

    render 'index'
  end
end
