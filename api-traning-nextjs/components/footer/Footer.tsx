import React from 'react'
import Link from 'next/link'
import { Card } from '../ui/card'

export const Footer: React.FC = () => {
  return (
    <Card className="w-full mt-auto p-4">
      <div className="flex justify-between items-center text-sm text-gray-600">
        <div>©Oki</div>
        <Link href="/privacy-policy" className="hover:underline">
          プライバシーポリシー
        </Link>
      </div>
    </Card>
  )
}
