--高速决斗技能-一手起动器
Duel.LoadScript("speed_duel_common.lua")
function c100730074.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730074.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730074.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.IsExistingMatchingCard(Card.IsAttribute,tp,LOCATION_DECK,0,1,nil,0x5f) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730074,0))
	else
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		local c=g:RandomSelect(tp,1)
		g:RemoveCard(c)
		aux.SpeedDuelSendToDeckWithExile(tp,g)
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetValue(2)
		Duel.RegisterEffect(e1,tp)
	end
end
