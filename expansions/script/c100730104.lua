--高速决斗技能-抽卡预感：暗
Duel.LoadScript("speed_duel_common.lua")
function c100730104.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(6733059,c)
	if not c100730104.UsedLP then
		c100730104.UsedLP={}
		c100730104.UsedLP[0]=0
		c100730104.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730104.skill,c100730104.con,aux.Stringid(100730104,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730104.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730104,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730104)
		c100730104.UsedLP[tp]=c100730104.UsedLP[tp]+1500
		local g=Duel.GetMatchingGroup(Card.IsAttribute,tp,LOCATION_DECK,0,nil,ATTRIBUTE_DARK)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730104.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsAttribute,tp,LOCATION_DECK,0,nil,ATTRIBUTE_DARK)>0
		and aux.DecreasedLP[tp]-c100730104.UsedLP[tp] >= 1500
end