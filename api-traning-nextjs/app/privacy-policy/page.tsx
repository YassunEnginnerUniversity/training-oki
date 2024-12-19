import React from 'react'
import { Card } from '../../components/ui/card'

export default function PrivacyPolicyPage() {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-6">プライバシーポリシー</h1>
      <Card className="p-6">
        <h2 className="text-xl font-bold mb-4">1. 個人情報の収集について</h2>
        <p className="mb-4">当サービスは、以下の場合に個人情報を収集することがあります：</p>
        <ul className="list-disc pl-6 mb-4">
          <li>アカウント作成時</li>
          <li>お問い合わせ時</li>
          <li>サービス利用時</li>
        </ul>

        <h2 className="text-xl font-bold mb-4">2. 個人情報の利用目的</h2>
        <p className="mb-4">収集した個人情報は、以下の目的で利用します：</p>
        <ul className="list-disc pl-6 mb-4">
          <li>サービスの提供・運営</li>
          <li>ユーザーサポート</li>
          <li>サービス改善</li>
        </ul>

        <h2 className="text-xl font-bold mb-4">3. 個人情報の第三者提供</h2>
        <p className="mb-4">法令に基づく場合を除き、個人情報を第三者に提供することはありません。</p>

        <h2 className="text-xl font-bold mb-4">4. セキュリティ対策</h2>
        <p className="mb-4">個人情報の漏洩、滅失、毀損の防止に努めます。</p>

        <h2 className="text-xl font-bold mb-4">5. プライバシーポリシーの変更</h2>
        <p className="mb-4">本ポリシーの内容は、法令変更等により予告なく変更することがあります。</p>
      </Card>
    </div>
  )
}
