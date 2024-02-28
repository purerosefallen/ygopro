--高速决斗技能-丑闻曝光
Duel.LoadScript("speed_duel_common.lua")
function c100730233.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730233.skill,c100730233.con,aux.Stringid(100730233,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730233.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,1,nil,0x12e)
end
function c100730233.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_HAND,0,1,1,nil,0x12e)
	local c=g:GetFirst()
	if c then
		Duel.Hint(HINT_CARD,1-tp,100730233)
		Duel.SendtoDeck(c,1-tp,nil,0,REASON_RULE)
		Duel.Draw(tp,1,REASON_RULE)
		c:ReverseInDeck()
		Duel.ShuffleDeck(1-tp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DRAW)
		e1:SetOperation(c100730233.tgop)
		e1:SetReset(RESET_EVENT+0x1de0000)
		c:RegisterEffect(e1)
	end
end
function c100730233.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730233)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
