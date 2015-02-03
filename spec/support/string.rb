class String
  def strip_heredoc
    indent = scan(/^[ \t]*(?=\S)/).min.size rescue 0
    gsub(/^[ \t]{#{indent}}/, '')
  end
end
