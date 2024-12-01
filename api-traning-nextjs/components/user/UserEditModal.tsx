'use client';

import { useActionState, useEffect, useState } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import { User, UserProfileResponse } from '@/types/user/types';
import { updateProfile } from '@/actions/user/updateProfile';

const initialState: UserProfileResponse = { error: '' };

interface UserEditModalProps {
  user: User;
}

const UserEditModal = ({ user }: UserEditModalProps) => {
  const [isOpen, setIsOpen] = useState(false);
  const [username, setUsername] = useState<string>(user.username);
  const [profile, setProfile] = useState<string>(user.profile);

  const [state, updateProfileAction, isPending] = useActionState(
    updateProfile,
    initialState,
  );

  // updateProfileActionの成功時にモーダルを閉じる
  useEffect(() => {
    if (!isPending && state && !('error' in state)) {
      setTimeout(() => {
        setIsOpen(false);
      }, 1000);
    }
  }, [isPending, state]);

  return (
    <Dialog open={isOpen} onOpenChange={setIsOpen}>
      <DialogTrigger asChild>
        <Button variant="outline">Edit Profile</Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold">Edit Profile</DialogTitle>
          <Button
            variant="ghost"
            className="absolute right-4 top-3 rounded-full p-2 h-4"
            onClick={() => setIsOpen(false)}
          ></Button>
        </DialogHeader>
        <form action={updateProfileAction}>
          {state && 'error' in state && (
            <p className="text-red-500">{state.error}</p>
          )}
          <div className="grid gap-4 py-4">
            <div className="grid gap-2">
              <Label htmlFor="username">Username</Label>
              <Input
                value={username}
                id="username"
                name="username"
                onChange={(e) => setUsername(e.target.value)}
                maxLength={50}
              />
            </div>
            <div className="grid gap-2">
              <Label htmlFor="profile">Profile</Label>
              <Textarea
                id="profile"
                name="profile"
                value={profile}
                onChange={(e) => setProfile(e.target.value)}
                maxLength={200}
                rows={7}
              />
              <p className="text-sm text-gray-500 text-right">
                {profile.length}/200
              </p>
            </div>
            <Input name="userId" value={user.id} type="hidden"></Input>
          </div>
          <div className="flex justify-end gap-2">
            <Button variant="outline" onClick={() => setIsOpen(false)}>
              Cancel
            </Button>
            <Button type="submit">Save</Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
};

export default UserEditModal;
