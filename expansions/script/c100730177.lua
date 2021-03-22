--高速决斗技能-挖金矿
Duel.LoadScript("speed_duel_common.lua")
function c100730177.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730177.operation,c100730177.con,aux.Stringid(100730177,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100730177.operation)
	c:RegisterEffect(e1)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730177.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,3,nil)
		and Duel.IsPlayerCanDraw(tp,1)
end
function c100730177.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:GetCount()>=3 then
		Duel.Hint(HINT_CARD,1-tp,100730177)
		local sg=g:Select(tp,3,3,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		if Duel.TossCoin(tp,1)==1 then
			local gold1=Duel.CreateToken(tp,55144522)
			Duel.SendtoDeck(gold1,tp,0,REASON_RULE)
			Duel.Draw(tp,1,REASON_RULE)
			Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730177,0))
		else Duel.Draw(tp,1,REASON_RULE)
		end
	end
	e:Reset()  
end