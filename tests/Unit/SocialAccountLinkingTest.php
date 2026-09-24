<?php

namespace Tests\Unit;

use Botble\SocialLogin\Services\SocialLoginService;
use Illuminate\Database\Eloquent\Model;
use PHPUnit\Framework\TestCase;

class SocialAccountLinkingTest extends TestCase
{
    protected function account(int $id): Model
    {
        $model = new class () extends Model {};
        $model->setAttribute($model->getKeyName(), $id);

        return $model;
    }

    public function test_new_email_can_always_register(): void
    {
        $this->assertTrue((new SocialLoginService())->mayLinkExistingAccount(null, null, false));
    }

    public function test_existing_account_is_not_linked_through_an_unverified_email(): void
    {
        $this->assertFalse((new SocialLoginService())->mayLinkExistingAccount($this->account(5), null, false));
    }

    public function test_existing_account_links_when_provider_verified_the_email(): void
    {
        $this->assertTrue((new SocialLoginService())->mayLinkExistingAccount($this->account(5), null, true));
    }

    public function test_identity_already_linked_to_the_account_can_log_in(): void
    {
        $this->assertTrue((new SocialLoginService())->mayLinkExistingAccount($this->account(5), $this->account(5), false));
    }

    public function test_identity_linked_to_another_account_cannot_be_moved_without_verification(): void
    {
        $this->assertFalse((new SocialLoginService())->mayLinkExistingAccount($this->account(5), $this->account(9), false));
    }

    public function test_provider_email_verification_flags(): void
    {
        $service = new SocialLoginService();

        $this->assertTrue($service->oauthEmailIsVerified('google', ['email_verified' => true]));
        $this->assertFalse($service->oauthEmailIsVerified('google', ['email_verified' => false]));
        $this->assertFalse($service->oauthEmailIsVerified('google', []));
        $this->assertTrue($service->oauthEmailIsVerified('apple', ['email_verified' => 'true']));
        $this->assertFalse($service->oauthEmailIsVerified('x', ['email' => 'a@b.c']));
        $this->assertFalse($service->oauthEmailIsVerified('github', []));
    }
}
