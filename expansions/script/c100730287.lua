--高速决斗技能-天使接力棒
Duel.LoadScript("speed_duel_common.lua")
function c100730287.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(365213,c)
	aux.SpeedDuelReplaceDraw(c,c100730287.skill,c100730287.con,aux.Stringid(100730287,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730287.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetTurnCount(tp)>=4
end
function c100730287.skill(e,tp,eg,ep,ev,re,r,rp)	
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730287)
	Duel.Draw(tp,2,REASON_RULE)
	Duel.ShuffleHand(tp)
	Duel.BreakEffect()
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DRAW)
	e1:SetValue(0)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end