import React from 'react'
import { Card, CardContent, CardFooter, CardHeader } from '@/components/ui/card'
import Link from 'next/link'
import { Button } from "@/components/ui/button"
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar"
import { MessageCircle } from 'lucide-react'
import LikeButton from '@/components/post/LikeButton'
import { Post } from '@/types/post/types'

interface PostItemProps {
  post: Post
}

const PostItem = ({post}: PostItemProps) => {
  return (
    <Card>
      <CardHeader>
        <div className="flex items-center space-x-4">
          <Avatar>
            <AvatarImage src="https://github.com/shadcn.png" alt="@shadcn" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
          <div>
            <Link href={`/user/${post.user.id}`} className="font-semibold hover:underline">
              { post.user.username }
            </Link>
            <p className="text-sm text-gray-500">@{post.user.username}</p>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <p className="leading-7">{post.content}</p>
      </CardContent>
      <CardFooter>
        <div className="flex space-x-4 text-gray-500">
          <LikeButton likesCount={post.likes_count} />
          <Button variant="ghost" size="sm">
              <MessageCircle className="w-4 h-4 mr-2" />
              {post.comments_count}
              </Button>
          <Button variant="ghost" size="sm">
          </Button>
        </div>
      </CardFooter>
    </Card>
  )
}

export default PostItem