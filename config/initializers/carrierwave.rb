CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AKIAWDXFBGIO64SKUOVB'],
    aws_secret_access_key: ENV['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'],
    region: ENV['ap-northeast-1'],
    path_style: true
  }
  config.fog_public = true
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  config.remove_previously_stored_files_after_update = false

  config.fog_directory = ENV['naturhythm-image']
  config.asset_host = ENV['naturhythm-image']
end
# 日本語の文字化けを防ぐ
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
