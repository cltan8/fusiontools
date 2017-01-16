module FusionsHelper
  def meta_refresh_tag nexturl
    return "<meta http-equiv=\"refresh\" content=\"900; URL=#{nexturl}\" >".html_safe
  end
end
