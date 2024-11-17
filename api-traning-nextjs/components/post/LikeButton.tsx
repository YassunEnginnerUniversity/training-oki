
import { Button } from '@/components/ui/button'
import { Heart, MessageCircle, Repeat2 } from 'lucide-react'

interface LikeButtonProps {
  likesCount: string
}

const LikeButton = ({likesCount}: LikeButtonProps) => {
  return (
    <Button type="submit" variant="ghost" size="sm">
      <Heart className="w-4 h-4 mr-2" />
      { likesCount }
    </Button>
  )
}

export default LikeButton