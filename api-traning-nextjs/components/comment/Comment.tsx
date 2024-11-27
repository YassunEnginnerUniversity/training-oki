import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Card, CardContent, CardHeader } from "@/components/ui/card"
import { CommentType } from "@/types/post/types"
import { formatDate } from "@/utils/formatDate"
import { generatePokemonIcon } from "@/utils/generatePokemonIcon"

interface CommentProps {
  comment: CommentType
}

const Comment = ({comment}: CommentProps) => {
  
  return (
    <Card className="mb-4">
      <CardHeader className="flex flex-row items-center gap-4">
          <Avatar>
            <AvatarImage src={`/pokemon/${generatePokemonIcon(comment.user.username)}.png`} alt={comment.user.username} />
            <AvatarFallback>{comment.user.username}</AvatarFallback>
          </Avatar>
        <div>
          <h2 className="text-base font-bold">{comment.user.username}</h2>
          <p className="text-sm text-muted-foreground">@{comment.user.username}</p>
        </div>
      </CardHeader>
      <CardContent>
        <p className="text-base mb-4">{comment.content}</p>
        <time className="text-sm text-muted-foreground">
          {formatDate(comment.created_at)}
        </time>
      </CardContent>
    </Card>
  )
}

export default Comment