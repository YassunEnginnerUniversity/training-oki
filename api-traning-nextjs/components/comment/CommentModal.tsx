"use client"

import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { useActionState, useState } from 'react';

import { MessageCircle } from 'lucide-react';
import { CreateComment } from '@/types/comment/type';
import { createComment } from '@/actions/comment/createComment';
import { Input } from '@/components/ui/input';

const initialState:CreateComment = { error: "" }

interface CommentModalProps {
  commentCount: string
  postId: string
}

const CommentModal = ({commentCount, postId}:CommentModalProps) => {
  const [state, crateCommentAction, isPending] = useActionState(createComment, initialState);
  const [postValue, setPostValue] = useState("");

  const handlePostValueChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setPostValue(e.target.value)
  }

  return (
    <Dialog >
      <DialogTrigger asChild>
        <Button variant="ghost" size="sm" aria-label={`コメント ${commentCount}件`}>
          <MessageCircle className="w-5 h-5 mr-2" />
          <span aria-hidden="true">{commentCount}</span>
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>New Comment</DialogTitle>
        </DialogHeader>
        {state.error && (<div className="">
          <p className="text-red-500 text-sm">{state.error}</p>
        </div>)}
        <form action={crateCommentAction}>
          <Textarea
            placeholder="what are you doing now"
            className="min-h-[100px]"
            name="content"
            onChange={handlePostValueChange}
            value={postValue}
          />
          <Input name="postId" value={postId} type="hidden"></Input>
          <div className="flex justify-between items-center mt-2">
            <span className={postValue.length > 120 ? "text-red-500" : "text-gray-500"}>
              {postValue.length}/120
            </span>
            <DialogFooter>
              <Button type="submit" disabled={isPending}>
                {isPending? "Commenting..." : "Comment"}
              </Button>
            </DialogFooter>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}

export default CommentModal