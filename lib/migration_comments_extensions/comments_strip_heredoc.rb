module MigrationComments::ActiveRecord::ConnectionAdapters
  class CommentDefinition
    # Remove common indent and leading/trailing newlines from multiline comments
    def comment_text_with_strip_heredoc
      text = comment_text_without_strip_heredoc
      text = text.strip_heredoc.strip if text.respond_to?(:strip_heredoc)
      text
    end

    alias_method_chain :comment_text, :strip_heredoc
    private :comment_text_with_strip_heredoc, :comment_text_without_strip_heredoc
  end
end
