defmodule App.Repo.Migrations.CriarTarefas do
  use Ecto.Migration

  def change do

    #Criar tabelas
    create table(:tarefas) do
      add :titulo, :string
      add :pronta, :boolean
    end

  end
end
