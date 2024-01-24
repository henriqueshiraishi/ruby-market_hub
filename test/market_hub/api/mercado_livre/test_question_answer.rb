# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestQuestionAnswer < Minitest::Test

  def setup
    @question_answer = MarketHub::API::MercadoLivre::QuestionAnswer.new(@@meli_access_token, @@meli_user_id)
  end

  def test_if_metrics_returns_response_time_not_found
    json = @question_answer.metrics

    refute_nil(json)
    assert_equal(json['status'], 404)
    assert_equal(json['error'], 'not_found')
    assert_equal(json['message'], 'Response time not found for user id: 1632856741')
  end

  def test_if_all_return_questions_list
    json = @question_answer.all({ status: 'ANSWERED', item: @@meli_item_id })

    refute_nil(json)
    assert_equal(json['limit'], 50)
    assert_equal(json['questions'].class, Array)
    assert_equal(json['questions'].first['id'], 12959618089)
    assert_equal(json['questions'].first['item_id'], 'MLB4389178328')
    assert_equal(json['questions'].first['status'], 'ANSWERED')
  end

  def test_if_find_return_question_detail
    question_id = '12959618089'
    json = @question_answer.find(question_id)

    refute_nil(json)
    assert_equal(json['id'], 12959618089)
    assert_equal(json['item_id'], 'MLB4389178328')
    assert_equal(json['status'], 'ANSWERED')
  end

  def test_if_anwser_already_answered
    question_id = '12959618089'
    json = @question_answer.anwser(question_id, 'TESTESTESTESTESTESTEST')

    refute_nil(json)
    assert_equal(json['status'], 400)
    assert_equal(json['error'], 'not_unanswered_question')
    assert_equal(json['message'], 'Question 12959618089 is not unanswered')
  end

  def test_if_destroy_return_already_answered
    question_id = '12959618089'
    json = @question_answer.destroy(question_id)

    refute_nil(json)
    assert_equal(json['status'], 400)
    assert_equal(json['error'], 'not_unanswered_question')
    assert_equal(json['message'], 'Question 12959618089 must be unanswered')
  end

end
