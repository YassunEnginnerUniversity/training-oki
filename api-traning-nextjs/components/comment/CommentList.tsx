import Comment from "@/components/comment/Comment"
import { CommentType } from "@/types/post/types"

interface CommentListProps {
  comments: CommentType[]
}

const CommentList = ({comments}:CommentListProps) => {
  return (
    <div>
      {comments?.map((comment) => (
        <Comment comment={comment} key={comment.id}/>
      ))}
    </div>
  )
}

export default CommentList