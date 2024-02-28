--高速决斗技能-抽卡预借
Duel.LoadScript("speed_duel_common.lua")
function c100730232.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730232.skill,c100730232.con,aux.Stringid(100730232,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730232.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,1,nil,67955331)
end
function c100730232.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730232)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,1,1,nil,67955331)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_RULE)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_SKIP_DP)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_END,3)
		Duel.RegisterEffect(e1,tp)
	end
end