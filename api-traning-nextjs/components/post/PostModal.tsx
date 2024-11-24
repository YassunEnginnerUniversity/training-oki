"use client"

import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { useActionState, useState } from 'react';
import { CreatePost } from '@/types/post/types';
import { createPost } from '@/actions/post/createPost';

const initialState:CreatePost = { error: "" }

const PostModal = () => {
  const [state, cratePostAction, isPending] = useActionState(createPost, initialState);
  const [postValue, setPostValue] = useState("");

  const handlePostValueChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setPostValue(e.target.value)
  }

  return (
    <Dialog >
      <DialogTrigger asChild>
        <Button>Create Post</Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>New Post</DialogTitle>
        </DialogHeader>
        {state.error && (<div className="">
          <p className="text-red-500 text-sm">{state.error}</p>
        </div>)}
        <form action={cratePostAction}>
          <Textarea
            placeholder="what are you doing now"
            className="min-h-[100px]"
            name="content"
            onChange={handlePostValueChange}
            value={postValue}
          />
          <div className="flex justify-between items-center mt-2">
            <span className={postValue.length > 140 ? "text-red-500" : "text-gray-500"}>
              {postValue.length}/140
            </span>
            <DialogFooter>
              <Button type="submit" disabled={isPending}>
                {isPending? "Posting..." : "Post"}
              </Button>
            </DialogFooter>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}

export default PostModal