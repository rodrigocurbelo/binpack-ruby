Rails.application.routes.draw do
  get '/' => "bin_packing#index"
  get '/pack' => "bin_packing#pack"
end
