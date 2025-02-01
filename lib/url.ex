defmodule Fields.Url do
  @moduledoc """
  An Ecto Type for urls.
  Use `Fields.UrlEncrypted` for encrypted urls.

  ## Example

      schema "retailers" do
        field :url, Fields.Url
      end
  """
  alias Fields.Validate
  use Ecto.Type

  def type, do: :string

  def cast(nil), do: {:ok, nil}

  def cast(value) do
    value = value |> to_string() |> String.trim()

    case Validate.url(value) do
      true -> {:ok, value}
      false -> :error
    end
  end

  def dump(value) do
    {:ok, to_string(value)}
  end

  def load(value) do
    {:ok, value}
  end

  def embed_as(_), do: :self

  def equal?(term1, term2), do: term1 == term2
end
