defmodule App.Tarefa do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Usuario

  # Criando model
  
  schema("tarefas") do
    field :titulo, :string
    field :pronta, :boolean
    belongs_to :usuario, Usuario
  end

  # Parametros de armazenamento

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:titulo, :pronta]) #converter os dados
    |> validate_required([:titulo, :pronta]) #campos obrigatórios
  end

  def soma(x \\ 1, y) do
    x + y
  end

end
