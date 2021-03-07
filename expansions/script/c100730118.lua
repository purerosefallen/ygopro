--高速决斗技能-抽卡预感：地缚神
Duel.LoadScript("speed_duel_common.lua")
function c100730118.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(44710391,c)
	if not c100730118.UsedLP then
		c100730118.UsedLP={}
		c100730118.UsedLP[0]=0
		c100730118.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730118.skill,c100730118.con,aux.Stringid(100730118,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730118.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730118,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730118)
		c100730118.UsedLP[tp]=c100730118.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x21)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730118.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x21)>0
		and aux.DecreasedLP[tp]-c100730118.UsedLP[tp] >= 1000
end