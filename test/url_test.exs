defmodule Fields.UrlTest do
  use ExUnit.Case
  alias Fields.{Url, UrlEncrypted}

  describe "types" do
    test "Url.type is :string" do
      assert Url.type() == :string
    end
  end

  describe "cast" do
    test "Url.cast accepts a nil" do
      assert {:ok, nil} == Url.cast(nil)
    end

    test "Url.cast accepts a string" do
      assert {:ok, "http://www.test.com"} == Url.cast("http://www.test.com")
    end

    test "Url.cast accepts a string with uppercase characters" do
      assert {:ok, "http://www.Test.com"} == Url.cast("http://www.Test.com")
    end

    test "Url.cast accepts a url with a query string" do
      assert {:ok, "http://www.test.com?foo=bar"} == Url.cast("http://www.test.com?foo=bar")
    end

    test "Url.cast accepts a url with a fragment" do
      assert {:ok, "http://www.test.com#something"} == Url.cast("http://www.test.com#something")
    end

    test "Url.cast requires a protocol scheme" do
      assert {:ok, "https://www.test.com"} == Url.cast("https://www.test.com")
      assert {:ok, "http://www.test.com"} == Url.cast("http://www.test.com")
      assert {:ok, "ftp://www.test.com"} == Url.cast("ftp://www.test.com")
      assert :error == Url.cast("://www.test.com")
      assert :error == Url.cast("www.test.com")
    end

    test "Url.cast validates url" do
      assert {:ok, "https://www.test.com"} == Url.cast("https://www.test.com ")
      # single forwardslash
      assert :error == Url.cast("http:/www.invalid_url.com")
      # test to_string works for numbers
      assert :error == Url.cast(1)
    end
  end

  describe "dump" do
    test "Url.dump returns a string" do
      assert {:ok, "http://www.test.com"} == Url.dump("http://www.test.com")
    end
  end

  describe "load" do
    test "Url.load returns a string" do
      assert {:ok, "http://www.test.com"} == Url.load("http://www.test.com")
    end
  end

  test "Url.equal?/2 confirms terms are equal" do
    assert Url.equal?("hello", "hello")
  end

  test "PhoneX embed_as/1 returns :self" do
    assert Url.embed_as(:self) == :self
    assert UrlEncrypted.embed_as(:self) == :self
  end
end
